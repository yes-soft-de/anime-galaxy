import { HttpEventType } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { ListCategory } from 'src/app/pages/categories/entity/list-category';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { ImageSnippet } from '../../entity/image-snippet';
import { AnimeService } from '../../services/anime.service';
import { Options } from 'select2';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';


@Component({
  selector: 'app-add-anime',
  templateUrl: './add-anime.component.html',
  styleUrls: ['./add-anime.component.scss']
})
export class AddAnimeComponent implements OnInit {
  allCategories: ListCategory[];
  generalRating = ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  mainUploadButtonValue = 'Upload';
  imageName = 'Select Image';
  mainImageName = 'Select Main Image';
  fileSelected = false;
  mainFileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  mainImageUrl: string;
  imagePathReady = false;
  mainImagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;
  public selectData: Array<{ id: string; text: string; }> = [];
  public options: Options;
  public value: string[] = [];

  constructor(private animeService: AnimeService,
              private tokenService: TokenService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    this.categoryService.allCategories().subscribe(
      (categories: ListCategoryResponse) => {
        console.log('all categories', categories);
        this.allCategories = categories.Data;
        this.allCategories.map(e => {
          // id : must be as string
          this.selectData.push({id: `${e.id}`, text: e.name});
        });
      }, error => console.log(error)
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      mainImage: [''],
      posterImage: [''],
      description: ['', [Validators.required, Validators.minLength(2)]],
      trailerVideo: ['', [Validators.required, Validators.minLength(2)]],
      episodesCount: ['', Validators.required],
      publishDate: ['', Validators.required],
      categories: [''],
      ageGroup: ['', Validators.required],
      generalRating: ['', [Validators.required, Validators.min(0), Validators.max(10)]],
      // suggest: ['', Validators.required]
    });

    // Options For Select 2
    this.options = {
      width: '100%',
      placeholder: 'Type Animes Categories',
      multiple: true,
      tags: true
    };
  }

  // Choose State Using Select Dropdown
  // changeCategory(event) {
  //   this.uploadForm.get('categories').setValue(event.target.value, {
  //     onlySelf : true
  //   });
  // }


  // changeGeneralRating(event) {
  //   this.uploadForm.get('generalRating').setValue(event.target.value, {
  //     onlySelf : true
  //   });
  // }

  // Choose If Globally Recommended Enimy
  // changeSuggest(event) {
  //   this.uploadForm.get('suggest').setValue(event.target.value, {
  //     onlySelf: true
  //   });
  // }


  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  updateMainName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.mainUploadButtonValue = 'Upload';
    this.mainImageName = file.name;
    this.mainFileSelected = true;
  }

  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'New Anime';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }

  processMainFile(imageInput: any) {
    this.mainFileSelected = false;
    this.mainUploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.mainImageUrl = res;
          this.mainUploadButtonValue = 'Uploaded';
          this.mainImagePathReady = true;
          this.submitButtonValue = 'New Anime';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.createdBy = this.tokenService.userName;
      formObject.categories = this.value;
      if (this.value.length == 0) {
        this.toaster.error('Error : Category Not Selected, Please Select One');
        this.isSubmitted = false;
        return false;
      }
      formObject.mainImage = this.imageUrl;
      formObject.posterImage = this.mainImageUrl;
      console.log(formObject);
      this.animeService.createAnime(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }


}
